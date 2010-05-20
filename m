From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Thu, 20 May 2010 14:38:16 +0930
Message-ID: <201005201438.17010.rusty__11491.8689629578$1274332224$gmane$org@rustcorp.com.au>
References: <20100505205814.GA7090@redhat.com> <4BF39C12.7090407@redhat.com>
	<201005201431.51142.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201005201431.51142.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 20 May 2010 02:31:50 pm Rusty Russell wrote:
> On Wed, 19 May 2010 05:36:42 pm Avi Kivity wrote:
> > > Note that this is a exclusive->shared->exclusive bounce only, too.
> > >    
> > 
> > A bounce is a bounce.
> 
> I tried to measure this to show that you were wrong, but I was only able
> to show that you're right.  How annoying.  Test code below.

This time for sure!

#define _GNU_SOURCE
#include <unistd.h>
#include <sched.h>
#include <err.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/mman.h>

/* We share memory via an mmap. */
struct counter {
	unsigned int cacheline1;
	char pad[256];
	unsigned int cacheline2;
};

#define MAX_BOUNCES 100000000

enum mode {
	SHARE,
	UNSHARE,
	LOCKSHARE,
	LOCKUNSHARE,
};

int main(int argc, char *argv[])
{
	cpu_set_t cpuset;
	volatile struct counter *counter;
	struct timeval start, stop;
	bool child;
	unsigned int count;
	uint64_t usec;
	enum mode mode;

	if (argc != 4)
		errx(1, "Usage: cachebounce share|unshare|lockshare|lockunshare <cpu0> <cpu1>");

	if (strcmp(argv[1], "share") == 0)
		mode = SHARE;
	else if (strcmp(argv[1], "unshare") == 0)
		mode = UNSHARE;
	else if (strcmp(argv[1], "lockshare") == 0)
		mode = LOCKSHARE;
	else if (strcmp(argv[1], "lockunshare") == 0)
		mode = LOCKSHARE;
	else
		errx(1, "Usage: cachebounce share|unshare|lockshare|lockunshare <cpu0> <cpu1>");

	CPU_ZERO(&cpuset);

	counter = mmap(NULL, getpagesize(), PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
	if (counter == MAP_FAILED)
		err(1, "Mapping page");

	/* Fault it in. */
	counter->cacheline1 = counter->cacheline2 = 0;

	child = (fork() == 0);

	CPU_SET(atoi(argv[2 + child]), &cpuset);
	if (sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset) != 0)
		err(1, "Calling sched_setaffinity()");

	gettimeofday(&start, NULL);

	if (child) {
		count = 1;
		switch (mode) {
		case SHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (counter->cacheline1 != count);
				count++;
				counter->cacheline1 = count;
				count++;
			}
			break;
		case UNSHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (counter->cacheline1 != count);
				count++;
				counter->cacheline2 = count;
				count++;
			}
			break;
		case LOCKSHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (__sync_val_compare_and_swap(&counter->cacheline1, count, count+1)
				       != count);
				count += 2;
			}
			break;
		case LOCKUNSHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (counter->cacheline1 != count);
				__sync_val_compare_and_swap(&counter->cacheline2, count, count+1);
				count += 2;
			}
			break;
		}
	} else {
		count = 0;
		switch (mode) {
		case SHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (counter->cacheline1 != count);
				count++;
				counter->cacheline1 = count;
				count++;
			}
			break;
		case UNSHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (counter->cacheline2 != count);
				count++;
				counter->cacheline1 = count;
				count++;
			}
			break;
		case LOCKSHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (__sync_val_compare_and_swap(&counter->cacheline1, count, count+1)
				       != count);
				count += 2;
			}
			break;
		case LOCKUNSHARE:
			while (count < MAX_BOUNCES) {
				/* Spin waiting for other side to change it. */
				while (counter->cacheline2 != count);
				__sync_val_compare_and_swap(&counter->cacheline1, count, count+1);
				count += 2;
			}
			break;
		}
	}
	gettimeofday(&stop, NULL);
	usec = (stop.tv_sec * 1000000LL + stop.tv_usec)
		- (start.tv_sec * 1000000LL + start.tv_usec);
	printf("CPU %s: %s cacheline: %llu usec\n", argv[2+child], argv[1], usec);
	return 0;
}

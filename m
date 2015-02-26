From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Thu, 26 Feb 2015 08:36:25 +0100
Message-ID: <20150226083625.2520ecb6__13247.5950093523$1424936213$gmane$org@oc7435384737.ibm.com>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87y4nllb85.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Peter Zijlstra <peterz@infradead.org>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 26 Feb 2015 11:50:42 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> >  Hi all,
> >
> > with the recent kernel 3.19, I get a kernel warning when I start my
> > KVM guest on s390 with virtio balloon enabled:
> 
> The deeper problem is that virtio_ccw_get_config just silently fails on
> OOM.
> 
> Neither get_config nor set_config are expected to fail.

AFAIK this is currently not a problem. According to
http://lwn.net/Articles/627419/ these kmalloc calls never
fail because they allocate less than a page.

 Thomas

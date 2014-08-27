From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: help? looking for limits on in-flight write operations for
	virtio-blk
Date: Tue, 26 Aug 2014 23:43:54 -0600
Message-ID: <53FD701A.4060204@windriver.com>
References: <53FB91BD.40403@windriver.com>
	<CAJSP0QU1e5eZoSm3nbBC4=ePHG21ABVh6+Kjo+SAFnvviLCPAg@mail.gmail.com>
	<53FCA088.7050108@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53FCA088.7050108@windriver.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Jeff Cody <jcody@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/26/2014 08:58 AM, Chris Friesen wrote:

> What I'd like to see (and may take a stab at implementing) is a cap on
> either inflight bytes or inflight IOPS.  One complication is that this
> requires hooking into the completion path to update the stats (and
> possibly unblock the I/O code) when an operation is done.

Well, it looks like I won't be taking a stab at this after all.

It seems that modifying qemu to call mallopt() to set the trim/mmap 
thresholds to 128K is enough to minimize the increase in RSS and also 
drop it back down after an I/O burst.  For now this looks like it should 
be sufficient for our purposes.

I'm actually a bit surprised I didn't have to go lower, but it seems to 
work for both "dd" and dbench testcases so we'll give it a try.

Chris

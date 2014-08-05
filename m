From: Amos Kong <akong@redhat.com>
Subject: Re: When I boot two virtio-rng devices, guest will hang
Date: Wed, 6 Aug 2014 01:45:26 +0800
Message-ID: <20140805174526.GA31480@z.redhat.com>
References: <20140728073242.GD2683@z.redhat.com>
	<20140728075514.GB3797@grmbl.mre>
	<20140728084920.GF2683@z.redhat.com>
	<20140728091213.GC3797@grmbl.mre>
	<20140728121120.GI2683@z.redhat.com>
	<20140805102854.GA7958@z.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140805102854.GA7958@z.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 05, 2014 at 06:28:54PM +0800, Amos Kong wrote:
> 3.16 (guest hangs with two rng devices)
> 3.16 + quick fix (can startup with two rng devices) (hotplug issue 1 + hotplug issue 2 exist)
> lates torvalds/linux.git + amit 4 patches (can startup with two rng devices) (only hotplug issue 2 exists)
> 
> However, the 4 patches also fixed the hang issue, the hotplug issue was fixed a little.
> The hotplug issue is effected by the backend, or maybe it's not a real issue, because
> the rng device can be hot-removed after dd process is killed.
> 
> 
> Hotplug issue 1:
>   1. boot up guest with two rng device (rng0 uses /dev/urandom, rng1 uses /dev/random)
>   2. read data by dd in guest
>   3 (option 1). hot-remove rng0, then hot-remove rng1 -> result: _only rng1_ can't be removed until dd process is killed
>   3 (option 2). hot-remove rng1, then hot-remove rng0 -> result: two devices can be removed successfully, dd process will exit automatically.
> 
>   If we use /dev/urandom for rng0 and rng1, _rng0 & rng1_ can be removed, dd process will exit automatically.
> 
> Hotplug issue 2:
>   If we use /dev/random for rng0 and rng1, _rng0 & rng1_ can't be removed until dd process is killed.
> 
> Hotplug issue 3:
>   If we use /dev/random for rng0 and rng1, _only rng1_ can't be removed until dd process is killed.

Hi Amit,

I finally found the root problem and posted a fix to upstream:
  http://lists.linuxfoundation.org/pipermail/virtualization/2014-August/027049.html

It can help to fix the hotplug issues on 3.16 & latest kernel, so
stable kernel is CCed.

> (The difference between /dev/random and /dev/urandom is the speed.)
> 
> Thanks, Amos

-- 
			Amos.

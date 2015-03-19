From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/1] Add virtio-input driver.
Date: Thu, 19 Mar 2015 18:05:16 +0100
Message-ID: <550B01CC.9030602@redhat.com>
References: <1426756391-26585-1-git-send-email-kraxel@redhat.com>	<20150319141302-mutt-send-email-mst@redhat.com>	<1426776404.10990.10.camel@nilsson.home.kraxel.org>
	<20150319164311-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150319164311-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 19/03/2015 17:33, Michael S. Tsirkin wrote:
> On Thu, Mar 19, 2015 at 03:46:44PM +0100, Gerd Hoffmann wrote:
>> Latest.  As far I know there never ever have been incompatible changes
>> to the interface, and given this is userspace/kernel abi I don't expect
>> that to happen in the future.
> 
> More events are added though, are they not? And distros backport rundom
> subsets.
> So I worry: what happens e.g. if you migrate between hosts which expose
> slightly different subsets of events?
> Might e.g. a button get stuck because button-press event was
> sent but button-release wasn't?

I think this is the same as SCSI.  You can migrate between hosts which
expose slightly different command sets.

Paolo

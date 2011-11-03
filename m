From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-pci new configuration proposal
Date: Thu, 03 Nov 2011 12:28:46 +1030
Message-ID: <8762j2t19l.fsf__40297.0845498659$1320292341$gmane$org@rustcorp.com.au>
References: <1320259767.22582.2.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1320259767.22582.2.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 02 Nov 2011 20:49:27 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> This is a proposal for a new layout of the virtio-pci config space.
> 
> We will separate the current configuration into two: A virtio-pci common
> configuration and a device specific configuration. This allows more flexibility
> with adding features and makes usage easier, specifically in cases like the
> ones in virtio-net where device specific configurations depend on device
> specific features.

Thanks for this Sasha.  Several general comments:

1) How to we distinguish the two layouts?  In theory, we need to do this
   forever.  In practice we can deprecate the old layout in several
   years' time.

2) I don't think we want to turn the device-specific config into a
   linked list.  We haven't needed variable-length config (yet!), and
   it's (slightly) more complex.  That's also the part of the spec which
   is shared with non-PCI virtio implementations.

3) If we're changing the queue layout, it's a chance to fix a
   longstanding bug: let the guest notify the host of preferred
   queue size and alignment.

Cheers,
Rusty.

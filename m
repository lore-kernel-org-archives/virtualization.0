From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [pciutils patch] add virtio vendor capability support
Date: Wed, 21 Jan 2015 16:16:40 +0100
Message-ID: <1421853400.10966.4.camel__4995.84848662398$1421853419$gmane$org@nilsson.home.kraxel.org>
References: <1421839293-4197-1-git-send-email-kraxel@redhat.com>
	<mj+md-20150121.144408.23951.nikam@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <mj+md-20150121.144408.23951.nikam@ucw.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Martin Mares <mj@ucw.cz>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mi, 2015-01-21 at 15:57 +0100, Martin Mares wrote:
> Hello!
> 
> > virtio uses vendor-specific capabilities to specify the location of
> > the virtio register ranges.  The specification can be found here:
> > 
> > http://docs.oasis-open.org/virtio/virtio/v1.0/cs01/virtio-v1.0-cs01.html#x1-690004
> > 
> > This patch adds support for decoding these capabilities to lspci.
> 
> I like the patch, except for a couple of details:
> 
> (1) Please follow the coding style of the rest of pciutils.

I've tried.  What specifically doesn't match?

> (2) You assume that PCI_CAP_ID_VNDR of all Redhat devices contains virtio,
>     but the comment nearby refers to a range of device IDs only.

I'll add a check.  Doesn't matter today, there are no other redhat
devices with vendor caps, so I was a bit lazy.  But who knows what
happens in the future ...

> (3) Moving code related to vendor-defined caps to a separate file sounds
>     good, but I think we should push the boundary a bit further: let the
>     main switch in ls-caps.c call a function from ls-caps-vendor.c as soon
>     as it finds PCI_CAP_ID_VENDOR, leaving all decisions based on
>     vendor/device ID to this function.

Makes sense indeed, will do.

cheers,
  Gerd

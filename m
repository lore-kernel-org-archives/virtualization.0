From: Martin Mares <mj@ucw.cz>
Subject: Re: [pciutils patch] add virtio vendor capability support
Date: Wed, 21 Jan 2015 15:57:47 +0100
Message-ID: <mj+md-20150121.144408.23951.nikam@ucw.cz>
References: <1421839293-4197-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421839293-4197-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello!

> virtio uses vendor-specific capabilities to specify the location of
> the virtio register ranges.  The specification can be found here:
> 
> http://docs.oasis-open.org/virtio/virtio/v1.0/cs01/virtio-v1.0-cs01.html#x1-690004
> 
> This patch adds support for decoding these capabilities to lspci.

I like the patch, except for a couple of details:

(1) Please follow the coding style of the rest of pciutils.

(2) You assume that PCI_CAP_ID_VNDR of all Redhat devices contains virtio,
    but the comment nearby refers to a range of device IDs only.

(3) Moving code related to vendor-defined caps to a separate file sounds
    good, but I think we should push the boundary a bit further: let the
    main switch in ls-caps.c call a function from ls-caps-vendor.c as soon
    as it finds PCI_CAP_ID_VENDOR, leaving all decisions based on
    vendor/device ID to this function.

Could you please fix these and resubmit?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
VI has two modes: the one in which it beeps and the one in which it doesn't.

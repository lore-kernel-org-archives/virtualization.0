From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH] LGUEST_GUEST: fix unmet direct dependencies
	(VIRTUALIZATION && VIRTIO)
Date: Tue, 4 Jan 2011 12:42:54 +1030
Message-ID: <201101041242.55157.rusty@rustcorp.com.au>
References: <201012271242.53835.toralf.foerster@gmx.de>
	<20110101110846.6a88bf7e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110101110846.6a88bf7e.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>, lguest-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2 Jan 2011 05:38:46 am Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings:
> VIRTIO and VIRTIO_RING are subordinate to VIRTUALIZATION.
> 
> warning: (LGUEST_GUEST) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)
> warning: (LGUEST_GUEST && VIRTIO_PCI && VIRTIO_BALLOON) selects VIRTIO_RING which has unmet direct dependencies (VIRTUALIZATION && VIRTIO)
> 
> Reported-by: Toralf F_rster <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
> Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Thanks, applied!

Rusty.

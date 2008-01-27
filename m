From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 1/2] dm-band: The I/O bandwidth controller: Source code
	patch
Date: Sun, 27 Jan 2008 16:44:53 +0100
Message-ID: <E1JJ9gj-0001SH-U2__25752.7253161699$1201448833$gmane$org@faramir.fjphome.nl>
References: <20080123.215350.193721890.ryov@valinux.co.jp>
	<20080123.215632.226773739.ryov@valinux.co.jp>
	<E1JHfjM-0003NV-BR@faramir.fjphome.nl>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-To: <E1JHfjM-0003NV-BR@faramir.fjphome.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Frans Pop wrote:
> The help should probably be a bit more verbose as this does not tell
> anybody much who has not already read the documentation.
> 
> Maybe something like:
> <snip>
> This device-mapper target allows to define how the
> available bandwith of a storage device should be
> shared between processes or cgroups.
> 
> Information on how to use dm-band is available in:
>    Documentation/device-mapper/band.txt
> </snip>

I just see in other Kconfig files that the last line should be:
   <file:Documentation/device-mapper/band.txt>.

Cheers,
FJP

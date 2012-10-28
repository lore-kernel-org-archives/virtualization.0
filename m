From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/16] treewide: Convert dev_printk(KERN_<LEVEL> to
	dev_<level>(
Date: Sun, 28 Oct 2012 05:12:15 -0700
Message-ID: <1351426335.2008.6.camel__36421.9991992742$1351427203$gmane$org@joe-AO722>
References: <cover.1351411047.git.joe@perches.com>
	<508D0ECA.8040008@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <508D0ECA.8040008@mvista.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-ide@vger.kernel.org, devel@open-fcoe.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2012-10-28 at 14:54 +0400, Sergei Shtylyov wrote:
> Hello.

Hi Sergei.

> On 28-10-2012 12:05, Joe Perches wrote:
> 
> > dev_<level> create smaller objects than dev_printk(KERN_<LEVEL>.
> > Convert non-debug calls to this form.
> 
> > Joe Perches (16):
> >    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
> [...]
> >    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
> [...]
> >    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
> 
>     Hm, somehow this patch is repeated thrice?

Nope, I forgot to edit the 0000 file after I edited
patches locally when I noticed I forgot to update
the subject lines.  Patches are corrected, 0000 not.

I don't think it's a bit deal, I could repost just the 0000
if you want though.

cheers, Joe

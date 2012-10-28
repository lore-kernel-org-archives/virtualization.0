From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 00/16] treewide: Convert dev_printk(KERN_<LEVEL> to
	dev_<level>(
Date: Sun, 28 Oct 2012 14:54:02 +0400
Message-ID: <508D0ECA.8040008__6160.57340889728$1351616675$gmane$org@mvista.com>
References: <cover.1351411047.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1351411047.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-ide@vger.kernel.org, devel@open-fcoe.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello.

On 28-10-2012 12:05, Joe Perches wrote:

> dev_<level> create smaller objects than dev_printk(KERN_<LEVEL>.
> Convert non-debug calls to this form.

> Joe Perches (16):
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
[...]
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
[...]
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(

    Hm, somehow this patch is repeated thrice?

MBR, Sergei

From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Xorg hangs in kernelspace with qxl
Date: Thu, 2 May 2019 07:26:30 +0200
Message-ID: <20190502052630.ombyxjhvx2hskxgv@sirius.home.kraxel.org>
References: <20e78e41-ed6a-a8ea-07e5-f83f353b8eaa@ristioja.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20e78e41-ed6a-a8ea-07e5-f83f353b8eaa@ristioja.ee>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jaak Ristioja <jaak@ristioja.ee>
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 01, 2019 at 12:47:48AM +0300, Jaak Ristioja wrote:
> Hello!
> 
> I'm experiencing the following task hangs at least 2-3 times a day when
> using a Kubuntu desktop in KVM via a SPICE client. This has occurred
> with the stock kernels in Kubuntu since Kubuntu 18.04. This makes the VM
> unusable as a graphical remote desktop and the hung task prevents
> Kubuntu from gracefully rebooting (e.g. "reboot" via SSH). Any ideas?
> 
> INFO: task Xorg:879 blocked for more than 120 seconds.
>       Not tainted 5.0.0-13-generic #14-Ubuntu

Does it happen with 5.1-rc kernels too?

cheers,
  Gerd

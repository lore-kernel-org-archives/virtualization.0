From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 char-misc-next 4/7] mic: vop: Add loopback driver
Date: Tue, 26 Feb 2019 12:56:18 +0100
Message-ID: <20190226115618.GB4094__12080.0760969118$1551182757$gmane$org@kroah.com>
References: <20190222153056.18878-1-vincent.whitchurch@axis.com>
	<20190222153056.18878-7-vincent.whitchurch@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190222153056.18878-7-vincent.whitchurch@axis.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Vincent Whitchurch <rabinv@axis.com>, arnd@arndb.de, linux-kernel@vger.kernel.org, sudeep.dutt@intel.com, virtualization@lists.linux-foundation.org, ashutosh.dixit@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 22, 2019 at 04:30:52PM +0100, Vincent Whitchurch wrote:
> Add a loopback driver to allow testing and evaluation of the VOP
> framework without special hardware.  The host and the guest will run
> under the same kernel.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/misc/mic/Kconfig            |  10 +
>  drivers/misc/mic/vop/Makefile       |   2 +
>  drivers/misc/mic/vop/vop_loopback.c | 382 ++++++++++++++++++++++++++++
>  3 files changed, 394 insertions(+)
>  create mode 100644 drivers/misc/mic/vop/vop_loopback.c

You sent 2 4/7 patches in this series, is that intentional?  Are they
different?

I've applied the first 3 here, can you rebase and resend the rest of
these, without any duplicated patches?

thanks,

greg k-h

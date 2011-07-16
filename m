From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 097/117] Staging: hv: storvsc: Add code to handle IDE
	devices using the storvsc driver
Date: Fri, 15 Jul 2011 22:04:47 -0400
Message-ID: <20110716020447.GB7199@infradead.org>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-97-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-97-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks, this looks much cleaner than the initial variant.

> +	if (dev_is_ide) {
> +		storvsc_get_ide_info(device, &target, &path);
> +		host_dev->path = device_info.path_id;
> +		host_dev->target = device_info.target_id;
> +	} else {
> +		host_dev->path = device_info.path_id;
> +		host_dev->target = device_info.target_id;
> +	}

Is using the device_info values in both branches intentional?  If so
there's no need to have these assignments duplicated.

> +	if (dev_is_ide) {
> +		ret = scsi_add_device(host, 0, target, 0);
> +		if (ret) {
> +			scsi_remove_host(host);
> +			goto err_out;
> +		}

I'd add another goto error label for this piece of error handling.

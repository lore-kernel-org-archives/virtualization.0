From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V3 3/5] vDPA: introduce vDPA bus
Date: Wed, 19 Feb 2020 20:06:13 -0800
Message-ID: <0a74e918-3b89-2aaf-7855-02db629ce886@infradead.org>
References: <20200220035650.7986-1-jasowang@redhat.com>
 <20200220035650.7986-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220035650.7986-4-jasowang@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On 2/19/20 7:56 PM, Jason Wang wrote:
> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
> new file mode 100644
> index 000000000000..7a99170e6c30
> --- /dev/null
> +++ b/drivers/virtio/vdpa/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VDPA
> +	tristate
> +        default m

Don't add drivers that are enabled by default, unless they are required
for a system to boot.

And anything that wants VDPA should just select it, so this is not needed.

> +        help
> +          Enable this module to support vDPA device that uses a
> +          datapath which complies with virtio specifications with
> +          vendor specific control path.
> +

thanks.
-- 
~Randy

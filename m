From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm: virtio: fix eno.cocci warnings
Date: Tue, 14 Mar 2017 14:44:55 +0100
Message-ID: <1489499095.27633.5.camel__2908.14009863443$1489499112$gmane$org@redhat.com>
References: <201703142048.yRK7v1yg%fengguang.wu@intel.com>
	<20170314123451.GA51889@lkp-sb04.lkp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170314123451.GA51889@lkp-sb04.lkp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kbuild-all@01.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

>  	vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
> -	if (IS_ERR(vbuf))
> +	if (!vbuf)
>  		return ERR_CAST(vbuf);

Well, ERR_CAST(vbuf) isn't correct either ...

correct fix has been committed to drm-misc-next today and should show up
in linux-next shortly.

cheers,
  Gerd

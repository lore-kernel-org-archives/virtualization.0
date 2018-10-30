From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
Date: Tue, 30 Oct 2018 07:11:27 +0100
Message-ID: <20181030061127.hp4n2scw5f3j2rqq__41967.5061050386$1540879787$gmane$org@sirius.home.kraxel.org>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-3-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181025183739.9375-3-robert.foss@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robert Foss <robert.foss@collabora.com>
Cc: Rob Herring <robh@kernel.org>, airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Gustavo Padovan <gustavo.padovan@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> The execbuffer IOCTL is now read-write to allow the userspace to read the
> out-fence.

>  #define DRM_IOCTL_VIRTGPU_EXECBUFFER \
> -	DRM_IOW(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
> +	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
>  		struct drm_virtgpu_execbuffer)

That changes the ioctl number and breaks the userspace api.

cheers,
  Gerd

From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-gpu: disable VIRGL with BE kernel
Date: Fri, 27 Jan 2017 09:15:26 +0100
Message-ID: <1485504926.19754.23.camel@redhat.com>
References: <1485263549-28743-1-git-send-email-lvivier@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1485263549-28743-1-git-send-email-lvivier@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Di, 2017-01-24 at 14:12 +0100, Laurent Vivier wrote:
> VIRTIO_GPU_F_VIRGL is added in features list only
> for LE kernel, so we must check for it only on LE kernel,
> otherwise virtio_has_feature() calls BUG() and
> crashes the kernel.
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Added to drm-qemu branch.

thanks,
  Gerd

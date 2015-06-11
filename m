From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [patch] drm/virtio: checking for NULL instead of IS_ERR
Date: Thu, 11 Jun 2015 08:16:59 +0200
Message-ID: <1434003419.27114.0.camel__12376.6916957267$1434003440$gmane$org@redhat.com>
References: <20150610192710.GA10145@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150610192710.GA10145@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mi, 2015-06-10 at 22:27 +0300, Dan Carpenter wrote:
> virtio_gpu_alloc_object() returns an error pointer, it never returns
> NULL.
> 
> Fixes: dc5698e80cf7 ('Add virtio gpu driver.')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

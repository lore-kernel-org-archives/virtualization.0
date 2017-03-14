From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm: qxl: add missing return check
Date: Tue, 14 Mar 2017 12:02:22 +0100
Message-ID: <1489489342.27633.3.camel__10211.4197020002$1489489358$gmane$org@redhat.com>
References: <20170314075410.GB5984@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170314075410.GB5984@mwanda>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>, Gabriel Krisman Bertazi <krisman@collabora.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Di, 2017-03-14 at 10:54 +0300, Dan Carpenter wrote:
> My static checker complains that "release" is uninitialized if
> qxl_alloc_release_reserved() fails, so let's add a check for that.

applied to drm-misc-next.

thanks,
  Gerd

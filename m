From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH][drm-next] drm/virtio: fix memory leak of vfpriv on error
	return path
Date: Wed, 14 Nov 2018 13:14:39 +0100
Message-ID: <20181114121438.3s4ehqahnqibrn2e__35300.9158665829$1542197557$gmane$org@sirius.home.kraxel.org>
References: <20181107203122.6861-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181107203122.6861-1-colin.king@canonical.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Colin King <colin.king@canonical.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 07, 2018 at 08:31:22PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation for vfpriv is being leaked on an error return path,
> fix this by kfree'ing it before returning.
> 
> Detected by CoverityScan, CID#1475380 ("Resource Leak")

Patches added to qemu queue, should land in drm-misc-next soon.

thanks,
  Gerd

From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm: qxl: Fix error handling at qxl_device_init
Date: Fri, 10 Aug 2018 08:03:29 +0200
Message-ID: <20180810060329.gipwvnw56v4gaela__13510.5295958512$1533880889$gmane$org@sirius.home.kraxel.org>
References: <20180727115440.11112-1-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180727115440.11112-1-vasilyev@ispras.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: ldv-project@linuxtesting.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 27, 2018 at 02:54:40PM +0300, Anton Vasilyev wrote:
> If qxl_device_init fails on creating resources and does not report it,
> then qxl module will catch null pointer exception on remove, or on
> probe's error path.
> 
> The patch adds error path with resources release into qxl_device_init.
> 
> Found by Linux Driver Verification project (linuxtesting.org).

Pushed to drm-misc-next.

thanks,
  Gerd

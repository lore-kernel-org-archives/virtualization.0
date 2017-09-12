From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm: qxl: ratelimit pr_info message, reduce log spamming
Date: Tue, 12 Sep 2017 16:21:57 +0200
Message-ID: <1505226117.31639.24.camel@redhat.com>
References: <20170912094548.30603-1-colin.king@canonical.com>
	<CACvgo53vbGbvejkEnQuuB-ZuVfbzvSmAsx3Ovj-wMWMQE8ihXw@mail.gmail.com>
	<20170912140921.maegwq32x5a6jyql@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170912140921.maegwq32x5a6jyql@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Emil Velikov <emil.l.velikov@gmail.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, Colin King <colin.king@canonical.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2017-09-12 at 17:09 +0300, Dan Carpenter wrote:
> On Tue, Sep 12, 2017 at 03:02:04PM +0100, Emil Velikov wrote:
> > That said, I'm not sure how useful the information is - perhaps
> > it's
> > better to drop it all together?
> 
> Or a WARN_ONCE().

It's userspace calling into the driver with invalid parameters.

IMO we should never WARN_ONCE() on something userspace can trigger.

I'd suggest to just drop the message altogether, simply throwing EINVAL
at userspace is perfectly fine IMHO.

cheers,
  Gerd

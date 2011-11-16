From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-mmio: Devices parameter parsing
Date: Wed, 16 Nov 2011 11:12:05 +1030
Message-ID: <87sjlooq3m.fsf@rustcorp.com.au>
References: <1321365185-2928-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321365185-2928-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 15 Nov 2011 13:53:05 +0000, Pawel Moll <pawel.moll@arm.com> wrote:
> +static char *virtio_mmio_cmdline_devices;
> +module_param_named(devices, virtio_mmio_cmdline_devices, charp, 0);

This is the wrong way to do this.

Don't put things in a charp and process it later.  It's lazy.  You
should write parsers for it and call it straight from module_param.

And if you do it that way, multiple devices are simply multiple
arguments.

Like so:

static int virtio_mmio_set(const char *val, const struct kernel_param *kp)
{
        if (!virtio_mmio_cmdline_parent_initialized) {
        	err = device_register(&virtio_mmio_cmdline_parent);
        	if (err)
        		return err;
                virtio_mmio_cmdline_parent_initialized = true;
        }
        
        ... parse here, return -errno on fail, 0 on success.
}

static struct kernel_param_ops param_ops_virtio_mmio = {
        .set = virtio_mmio_set,
        .get = virtio_mmio_get,
};

module_param_cb(device, &param_ops_virtio_mmio, NULL, 0400);

Initialization and error handling is now done for you...

Cheers,
Rusty.

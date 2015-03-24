From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3] Add virtio-input driver.
Date: Tue, 24 Mar 2015 11:26:50 +0100
Message-ID: <1427192810.18768.4.camel__35053.6554157317$1427192828$gmane$org@nilsson.home.kraxel.org>
References: <1427182321-19451-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427182321-19451-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, mst@redhat.com, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Herrmann <dh.herrmann@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> +static void virtinput_cfg_abs(struct virtio_input *vi, int abs)
> +{
> +	u32 mi, ma, re, fu, fl;
> +
> +	virtinput_cfg_select(vi, VIRTIO_INPUT_CFG_ABS_INFO, abs);
> +	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.min, &mi);
> +	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.max, &ma);
> +	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.res, &re);
> +	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.fuzz, &fu);
> +	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.flat, &fl);
> +	input_set_abs_params(vi->idev, abs, mi, ma, fu, fl);
> +	input_abs_set_res(vi->idev, abs, re);
> +}

> +struct virtio_input_absinfo {
> +	__virtio32  min;
> +	__virtio32  max;
> +	__virtio32  fuzz;
> +	__virtio32  flat;
> +	__virtio32  res;
> +};

Damn, had sparse disabled for the test builds.  [ Too bad there are way
too many warnings on a full kernel build so having sparse enabled all
the time doesn't fly. ]

So this doesn't work either.

Hmm, back to using "u32" in the virtio config structs?

cheers,
  Gerd

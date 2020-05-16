From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH 5/6] vhost: add an rpmsg API
Date: Sat, 16 May 2020 12:00:35 -0500
Message-ID: <9737e3f2-e59c-0174-9254-a2d8f29f30b7@linux.intel.com>
References: <20200516101109.2624-1-guennadi.liakhovetski@linux.intel.com>
 <20200516101109.2624-6-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200516101109.2624-6-guennadi.liakhovetski@linux.intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, kvm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org


> +config VHOST_RPMSG
> +	tristate
> +	depends on VHOST

depends on RPMSG_VIRTIO?

> +	default n

not needed

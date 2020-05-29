From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 0/5] Add a vhost RPMsg API
Date: Fri, 29 May 2020 14:01:53 +0800
Message-ID: <044a3b81-e0fd-5d96-80ff-b13e587f9d39@redhat.com>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, kvm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/28 上午2:05, Guennadi Liakhovetski wrote:
> v3:
> - address several checkpatch warnings
> - address comments from Mathieu Poirier
>
> v2:
> - update patch #5 with a correct vhost_dev_init() prototype
> - drop patch #6 - it depends on a different patch, that is currently
>    an RFC
> - address comments from Pierre-Louis Bossart:
>    * remove "default n" from Kconfig
>
> Linux supports RPMsg over VirtIO for "remote processor" /AMP use
> cases. It can however also be used for virtualisation scenarios,
> e.g. when using KVM to run Linux on both the host and the guests.
> This patch set adds a wrapper API to facilitate writing vhost
> drivers for such RPMsg-based solutions. The first use case is an
> audio DSP virtualisation project, currently under development, ready
> for review and submission, available at
> https://github.com/thesofproject/linux/pull/1501/commits
> A further patch for the ADSP vhost RPMsg driver will be sent
> separately for review only since it cannot be merged without audio
> patches being upstreamed first.


Hi:

It would be hard to evaluate this series without a real user. So if 
possible, I suggest to post the actual user for vhost rpmsg API.

Thanks


>
> Thanks
> Guennadi

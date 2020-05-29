From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Add a vhost RPMsg API
Date: Fri, 29 May 2020 08:50:51 +0200
Message-ID: <20200529065050.GA6002@ubuntu>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
 <044a3b81-e0fd-5d96-80ff-b13e587f9d39@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <044a3b81-e0fd-5d96-80ff-b13e587f9d39@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Jason,

On Fri, May 29, 2020 at 02:01:53PM +0800, Jason Wang wrote:
> 
> On 2020/5/28 上午2:05, Guennadi Liakhovetski wrote:
> > v3:
> > - address several checkpatch warnings
> > - address comments from Mathieu Poirier
> > 
> > v2:
> > - update patch #5 with a correct vhost_dev_init() prototype
> > - drop patch #6 - it depends on a different patch, that is currently
> >    an RFC
> > - address comments from Pierre-Louis Bossart:
> >    * remove "default n" from Kconfig
> > 
> > Linux supports RPMsg over VirtIO for "remote processor" /AMP use
> > cases. It can however also be used for virtualisation scenarios,
> > e.g. when using KVM to run Linux on both the host and the guests.
> > This patch set adds a wrapper API to facilitate writing vhost
> > drivers for such RPMsg-based solutions. The first use case is an
> > audio DSP virtualisation project, currently under development, ready
> > for review and submission, available at
> > https://github.com/thesofproject/linux/pull/1501/commits
> > A further patch for the ADSP vhost RPMsg driver will be sent
> > separately for review only since it cannot be merged without audio
> > patches being upstreamed first.
> 
> 
> Hi:
> 
> It would be hard to evaluate this series without a real user. So if
> possible, I suggest to post the actual user for vhost rpmsg API.

Sure, the whole series is available at 
https://github.com/thesofproject/linux/pull/1501/commits or would you 
prefer the missing patches posted to the lists too?

Thanks
Guennadi

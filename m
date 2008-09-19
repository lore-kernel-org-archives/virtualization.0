From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Subject: Re: dm-ioband + bio-cgroup benchmarks
Date: Fri, 19 Sep 2008 17:49:24 +0900
Message-ID: <48D36794.6010002__7233.78654006428$1221814217$gmane$org@oss.ntt.co.jp>
References: <20080918.210418.226794540.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080918.210418.226794540.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, xemul@openvz.org, fernando@oss.ntt.co.jp, kamezawa.hiroyu@jp.fujitsu.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Tsuruta-san,

Ryo Tsuruta wrote:
> Hi All,
> 
> I have got excellent results of dm-ioband, that controls the disk I/O
> bandwidth even when it accepts delayed write requests.
> 
> In this time, I ran some benchmarks with a high-end storage. The
> reason was to avoid a performance bottleneck due to mechanical factors
> such as seek time.
> 
> You can see the details of the benchmarks at:
> http://people.valinux.co.jp/~ryov/dm-ioband/hps/
> 

I took a look at your beautiful results!
When you have time, would you explain me how you succeeded to check the
time, bandwidth, especially when you did write() tests? Actually, I tried
similar tests and failed to check the bandwidth correctly. Did you insert
something in the kernel source?

Thanks,
Takuya Yoshikawa

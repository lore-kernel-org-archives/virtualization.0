From: "Satoshi UCHIDA" <s-uchida@ap.jp.nec.com>
Subject: RE: [PATCH][RFC][12+2][v3] A expanded CFQ scheduler for cgroups
Date: Wed, 12 Nov 2008 18:22:29 +0900
Message-ID: <000001c944a8$2f3867b0$8da93710$__16351.8807538368$1226482176$gmane$org@jp.nec.com>
References: <000c01c9449e$c5bcdc20$51369460$@jp.nec.com>
	<1226480279.7685.2980.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1226480279.7685.2980.camel@twins>
Content-Language: ja
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: 'Hirokazu Takahashi' <taka@valinux.co.jp>, paolo.valente@unimore.it, 'SUGAWARA Tomoyoshi' <tom-sugawara@ap.jp.nec.com>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vtaras@openvz.org, menage@google.com, jens.axboe@oracle.com, 'Fabio Checconi' <fabio@gandalf.sssup.it>, 'Andrew Morton' <akpm@linux-foundation.org>, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, 'Andrea Righi' <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi, Peter.

> Just wondering,.. have you lot looked at the recently posted BFQ
> patches?
> 
> BFQ looks like a very promising elevator, its has tighter bounds than
> CFQ and already does the cgroup thing.


This patchset is improved our previous scheduler(sent 04/01/2008) and resolves some problems.

And, we scheduler can control at the two layers.
Namely, it can control I/O among groups and I/O among tasks within a group.

I always check in containers ML mainly.
So, I found I/O control patches in it ML, dm-iobnd, io-throttle, Naveen's Anticipatory I/O scheduler,
Vasily's CFQ scheduler and Vivek's Another IO controller.
And today I know the BFQ scheduler, so I'm not looked at the BFQ yet.
Now, I'm looking its patch.

Thanks, comments.


Satoshi UCHIDA


> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Wednesday, November 12, 2008 5:58 PM
> To: Satoshi UCHIDA
> Cc: linux-kernel@vger.kernel.org;
> containers@lists.linux-foundation.org;
> virtualization@lists.linux-foundation.org; jens.axboe@oracle.com; 'Ryo
> Tsuruta'; 'Andrea Righi'; ngupta@google.com; fernando@oss.ntt.co.jp;
> vtaras@openvz.org; 'Hirokazu Takahashi'; balbir@linux.vnet.ibm.com;
> 'Andrew Morton'; menage@google.com; SUGAWARA Tomoyoshi;
> paolo.valente@unimore.it; Fabio Checconi
> Subject: Re: [PATCH][RFC][12+2][v3] A expanded CFQ scheduler for cgroups
> 
> Hi,
> 
> Just wondering,.. have you lot looked at the recently posted BFQ
> patches?
> 
> BFQ looks like a very promising elevator, its has tighter bounds than
> CFQ and already does the cgroup thing.
> 


> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Wednesday, November 12, 2008 5:58 PM
> To: Satoshi UCHIDA
> Cc: linux-kernel@vger.kernel.org;
> containers@lists.linux-foundation.org;
> virtualization@lists.linux-foundation.org; jens.axboe@oracle.com; 'Ryo
> Tsuruta'; 'Andrea Righi'; ngupta@google.com; fernando@oss.ntt.co.jp;
> vtaras@openvz.org; 'Hirokazu Takahashi'; balbir@linux.vnet.ibm.com;
> 'Andrew Morton'; menage@google.com; SUGAWARA Tomoyoshi;
> paolo.valente@unimore.it; Fabio Checconi
> Subject: Re: [PATCH][RFC][12+2][v3] A expanded CFQ scheduler for cgroups
> 
> Hi,
> 
> Just wondering,.. have you lot looked at the recently posted BFQ
> patches?
> 
> BFQ looks like a very promising elevator, its has tighter bounds than
> CFQ and already does the cgroup thing.
> 

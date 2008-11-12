From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH][RFC][12+2][v3] A expanded CFQ scheduler for cgroups
Date: Wed, 12 Nov 2008 09:57:59 +0100
Message-ID: <1226480279.7685.2980.camel__24084.2741368853$1226481445$gmane$org@twins>
References: <000c01c9449e$c5bcdc20$51369460$@jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <000c01c9449e$c5bcdc20$51369460$@jp.nec.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Satoshi UCHIDA <s-uchida@ap.jp.nec.com>
Cc: 'Hirokazu Takahashi' <taka@valinux.co.jp>, paolo.valente@unimore.it, SUGAWARA Tomoyoshi <tom-sugawara@ap.jp.nec.com>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vtaras@openvz.org, menage@google.com, jens.axboe@oracle.com, Fabio Checconi <fabio@gandalf.sssup.it>, 'Andrew Morton' <akpm@linux-foundation.org>, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, 'Andrea Righi' <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Just wondering,.. have you lot looked at the recently posted BFQ
patches?

BFQ looks like a very promising elevator, its has tighter bounds than
CFQ and already does the cgroup thing.

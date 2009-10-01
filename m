From: Javier Guerra <javier@guerrag.com>
Subject: Re: INFO: task kjournal:337 blocked for more than 120 seconds
Date: Thu, 1 Oct 2009 16:03:19 -0500
Message-ID: <90eb1dc70910011403q31218381tec865b1ecd361eff__5971.08488805151$1254431067$gmane$org@mail.gmail.com>
References: <1254345112.8837.9.camel@localhost.localdomain>
	<20091001132012.GA16975@amt.cnet>
	<1254416336.6787.6.camel@localhost.localdomain>
	<1254430820.5033.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254430820.5033.4.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shirley Ma <mashirle@us.ibm.com>
Cc: mcao@us.ibm.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 1, 2009 at 4:00 PM, Shirley Ma <mashirle@us.ibm.com> wrote:
> I talked to Mingming, she suggested to use different IO scheduler. The
> default scheduler is cfg, after I switch to noop, the problem is gone.

deadline is the most recommended one for virtualization hosts.  some
distros set it as default if you select Xen or KVM at installation
time.  (and noop for the guests)


-- 
Javier

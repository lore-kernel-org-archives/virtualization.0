From: Shirley Ma <mashirle@us.ibm.com>
Subject: Re: INFO: task kjournal:337 blocked for more than 120 seconds
Date: Thu, 01 Oct 2009 14:17:21 -0700
Message-ID: <1254431841.5033.5.camel__16759.9754561254$1254431883$gmane$org@localhost.localdomain>
References: <1254345112.8837.9.camel@localhost.localdomain>
	<20091001132012.GA16975@amt.cnet>
	<1254416336.6787.6.camel@localhost.localdomain>
	<1254430820.5033.4.camel@localhost.localdomain>
	<90eb1dc70910011403q31218381tec865b1ecd361eff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <90eb1dc70910011403q31218381tec865b1ecd361eff@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Javier Guerra <javier@guerrag.com>
Cc: mcao@us.ibm.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2009-10-01 at 16:03 -0500, Javier Guerra wrote:
> deadline is the most recommended one for virtualization hosts.  some
> distros set it as default if you select Xen or KVM at installation
> time.  (and noop for the guests)

I spoke too earlier, after a while noop scheduler hit the same issue. I
am switching to deadline to test it again.

Thanks
Shirley

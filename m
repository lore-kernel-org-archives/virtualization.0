From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH RFC 2/5] vringfd base/offset
Date: Sat, 05 Apr 2008 15:44:33 +0300
Message-ID: <47F77431.3030608__13835.8328877532$1207399604$gmane$org@qumranet.com>
References: <200804052202.09157.rusty@rustcorp.com.au>
	<200804052204.28518.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804052204.28518.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> It turns out the lguest (and possibly kvm) want the addresses in the
> ring buffer to only cover a certain part of memory, and be offset.
>
>  					<mailto:rusty@rustcorp.com.au>	
> +0xAE	00-01	linux/vring.h
>   

Another virtualization subsystem already uses this range.


-- 
Any sufficiently difficult bug is indistinguishable from a feature.

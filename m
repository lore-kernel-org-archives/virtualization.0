From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sat, 19 Jan 2008 10:44:52 +0900
Message-ID: <47915614.7080608__25706.7672363066$1200707282$gmane$org@gmail.com>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801190727.36567.rusty@rustcorp.com.au>
	<47913261.5000708@gmail.com>
	<200801191228.30363.rusty@rustcorp.com.au>
	<47915515.1020905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47915515.1020905@gmail.com>
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
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>, Jeff Garzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

Tejun Heo wrote:
> so I think the question is "do we want to change all callbacks to
> take native pointer type instead of void pointer?".

Lemme clarity myself a bit.  I'm not saying that we should convert all
at once or literally every callback should be converted.  What I'm
saying is whether we're headed that way in general and converting big
ones - timer for example - and getting the conversion agreed upon should
be enough to set the norm.

Thanks.

-- 
tejun

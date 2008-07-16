From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout v2
Date: Wed, 16 Jul 2008 03:11:15 -0700
Message-ID: <487DC943.5060202__19500.8493065417$1216203231$gmane$org@goop.org>
References: <487B05CE.1050508@jp.fujitsu.com> <487D78A3.6050105@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <487D78A3.6050105@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hidetoshi Seto wrote:
> +#ifdef CONFIG_STOP_MACHINE
> +extern unsigned long stopmachine_timeout;
> +#endif
>   

No externs in C files. Put it in an appropriate header.

I'll do a proper review soon.

J

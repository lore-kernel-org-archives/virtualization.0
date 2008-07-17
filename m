From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout v2
Date: Thu, 17 Jul 2008 12:40:14 +0900
Message-ID: <487EBF1E.5030109__21445.6201218583$1216266147$gmane$org@jp.fujitsu.com>
References: <487B05CE.1050508@jp.fujitsu.com>
	<487D78A3.6050105@jp.fujitsu.com> <487DC943.5060202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <487DC943.5060202@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Hidetoshi Seto wrote:
>> +#ifdef CONFIG_STOP_MACHINE
>> +extern unsigned long stopmachine_timeout;
>> +#endif
> 
> No externs in C files. Put it in an appropriate header.

sysctl.c already has many externs... but I can fix at least
the above.

> I'll do a proper review soon.

Is it better to postpone v4 until your comment comes?

Thanks,
H.Seto

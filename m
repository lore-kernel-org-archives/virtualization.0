From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH -next] virtio_console: make local symbols static
Date: Mon, 08 Apr 2013 22:58:45 +0930
Message-ID: <87d2u59mnm.fsf__48466.0386493944$1365440144$gmane$org@rustcorp.com.au>
References: <CAPgLHd8ffGFuLdAFnx=bDmBS5U0FrH-fqCeneOHeWQQSE+v4wg@mail.gmail.com>
	<20130408055354.GC16207@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130408055354.GC16207@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Wei Yongjun <weiyj.lk@gmail.com>
Cc: gregkh@linuxfoundation.org, yongjun_wei@trendmicro.com.cn, linux-kernel@vger.kernel.org, arnd@arndb.de, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:

> On (Sat) 06 Apr 2013 [11:52:07], Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> Those symbols only used within this file, and should be static.
>> 
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Acked-by: Amit Shah <amit.shah@redhat.com>
>
> 		Amit

Thanks, applied.

Cheers,
Rusty.

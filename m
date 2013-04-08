From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH -next] virtio_console: make local symbols static
Date: Mon, 8 Apr 2013 11:23:54 +0530
Message-ID: <20130408055354.GC16207__28516.1655200229$1365405044$gmane$org@amit.redhat.com>
References: <CAPgLHd8ffGFuLdAFnx=bDmBS5U0FrH-fqCeneOHeWQQSE+v4wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd8ffGFuLdAFnx=bDmBS5U0FrH-fqCeneOHeWQQSE+v4wg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, yongjun_wei@trendmicro.com.cn
List-Id: virtualization@lists.linuxfoundation.org

On (Sat) 06 Apr 2013 [11:52:07], Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Those symbols only used within this file, and should be static.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Amit Shah <amit.shah@redhat.com>

		Amit

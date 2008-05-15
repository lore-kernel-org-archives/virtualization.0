From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Thu, 15 May 2008 18:32:47 +0300
Message-ID: <482C579F.4030509__40731.0339659036$1210866295$gmane$org@qumranet.com>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>	
	<1210624663.14409.20.camel@muff> <48294776.3010504@qumranet.com>	
	<200805141607.26306.rusty@rustcorp.com.au>
	<482AAA0F.2020607@qumranet.com> <1210865380.16012.15.camel@muff>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1210865380.16012.15.camel@muff>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Mark McLoughlin wrote:
> I think Rusty is speaking from the POV of the guest driver - i.e. that
> virtio_net should never disable notifications on the xmit queue using
> disable_cb()?
>
> Sounds like you think agree, but that the host side should throttle the
> rate of xmit notifications?
>   

Yes.

-- 
error compiling committee.c: too many arguments to function

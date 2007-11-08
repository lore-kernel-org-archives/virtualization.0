From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Lguest] [PATCH] virtio config_ops refactoring
Date: Thu, 08 Nov 2007 16:49:02 -0600
Message-ID: <4733925E.3050208@us.ibm.com>
References: <4730A8F3.6020008@us.ibm.com>
	<200711081320.35844.rusty__6233.15023626692$1194488552$gmane$org@rustcorp.com.au>
	<4732774C.6020903@codemonkey.ws>
	<200711090924.28659.rusty@rustcorp.com.au>
	<47338EA0.6050100@codemonkey.ws>
	<13426df10711081447o688550a4jc01be2d7f06209e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <13426df10711081447o688550a4jc01be2d7f06209e0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ron minnich <rminnich@gmail.com>
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

ron minnich wrote:
> Hi, I'm sorry, I've been stuck on other things (NFS RDMA anyone?) and
> missed part of this discussion.
>
> Is it really the case that operations on virtio devices will involve
> outl/inl etc.?
>   

No, this is just for the PCI virtio transport.  lguest's virtio 
transport uses hypercalls and shared memory.

Regards,

Anthony Liguori

> Apologies in advance for my failure to pay attention.
>
> thanks
>
> ron
>   

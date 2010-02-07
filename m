From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] vhost-net: switch to smp barriers
Date: Sun, 07 Feb 2010 11:42:29 +0200
Message-ID: <4B6E8B05.8070607@redhat.com>
References: <20100201172101.GA10900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20100201172101.GA10900@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 02/01/2010 07:21 PM, Michael S. Tsirkin wrote:
> vhost-net only uses memory barriers to control SMP effects
> (communication with userspace potentially running on a different CPU),
> so it should use SMP barriers and not mandatory barriers for memory
> access ordering, as suggested by Documentation/memory-barriers.txt
>
>    

A UP guest running on an SMP host still needs those barriers.

-- 
error compiling committee.c: too many arguments to function


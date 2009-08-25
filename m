From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 08:08:05 -0500
Message-ID: <4A93E235.5040008__12344.1952783198$1251205922$gmane$org@codemonkey.ws>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
	<20090825064604.GB10429@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090825064604.GB10429@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
>> My preference is ring proxying.  Not we'll need ring proxying (or at  
>> least event proxying) for non-MSI guests.
>>     
>
> Exactly, that's what I meant earlier. That's enough, isn't it, Anthony?
>   

It is if we have a working implementation that demonstrates the 
userspace interface is sufficient.  Once it goes into the upstream 
kernel, we need to have backwards compatibility code in QEMU forever to 
support that kernel version.

Regards,

Anthony Liguori

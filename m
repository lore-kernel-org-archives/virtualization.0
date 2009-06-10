From: Avi Kivity <avi@redhat.com>
Subject: Re: TODO list for qemu+KVM networking performance v2
Date: Wed, 10 Jun 2009 18:18:01 +0300
Message-ID: <4A2FCEA9.8010604__31890.8899593682$1244647137$gmane$org@redhat.com>
References: <20090604164320.GB14592@redhat.com>
	<200906101309.14532.rusty@rustcorp.com.au>
	<4A2F5217.9090401@redhat.com>
	<200906110009.34671.rusty@rustcorp.com.au>
	<20090610145358.GB28601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090610145358.GB28601@redhat.com>
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
Cc: Chris Wright <chrisw@redhat.com>, Mark McLoughlin <markmc@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Brian Stein <bstein@redhat.com>, Herbert Xu <herbert.xu@redhat.com>, virtualization@lists.linux-foundation.org, Dor Laor <dor@redhat.com>, Yaron Haviv <yaronh@voltaire.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> But I don't understand how aio will make implementing it easier -
> or are you merely saying that it will make it worthwhile?
>   

If you have aio, the the NIC and the guest proceed in parallel.  If the 
guest is faster (likely), then when it sends the next packet it will see 
that interrupts are disabled and not notify again.  Once aio complete we 
can recheck the queue; if it's empty we reenable notifications.  If 
there's still stuff in it we submit it with notifications disabled.

-- 
error compiling committee.c: too many arguments to function

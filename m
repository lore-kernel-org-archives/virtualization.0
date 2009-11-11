From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio: Add memory statistics reporting to the
	balloon driver
Date: Wed, 11 Nov 2009 17:00:02 +0200
Message-ID: <4AFAD172.4090003__17114.20748984$1257951785$gmane$org@redhat.com>
References: <1257782838.2835.5.camel@aglitke>	
	<1257784326.2835.16.camel@aglitke>	
	<200911101312.02650.rusty@rustcorp.com.au>
	<4AF97A5E.1070801@codemonkey.ws>	 <4AF97C1A.2080609@redhat.com>
	<4AF97F93.2080707@us.ibm.com>	
	<20091111092409.GA24646@shareable.org>
	<20091111101223.GA22937@redhat.com>
	<1257945984.2876.1.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257945984.2876.1.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <agl@us.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, agl@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/11/2009 03:26 PM, Adam Litke wrote:
> On Wed, 2009-11-11 at 10:12 +0000, Daniel P. Berrange wrote:
>    
>> This all suggests that we should only update the stats from the guest
>> when something on the host actually asks for them by issuing the QEMU
>> monitor command. We don't want any kind of continuous polling of stats
>> at any frequency, if nothing is using these stats on the host.
>>      
> Agreed.  The next version of the patch will remove the timer completely.
> We'll wake up in response to config change notifications only.
>    

A vq with its own interrupt would be much nicer.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

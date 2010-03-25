From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/1] Shared memory uio_pci driver
Date: Thu, 25 Mar 2010 12:07:41 +0200
Message-ID: <20100325100741.GB15306__42104.4958675795$1269511922$gmane$org@redhat.com>
References: <1269497376-21903-1-git-send-email-cam@cs.ualberta.ca>
	<20100325091552.GB11153@redhat.com> <4BAB2F79.7030706@redhat.com>
	<20100325094448.GA15306@redhat.com> <4BAB33C6.3060504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BAB33C6.3060504@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 25, 2010 at 11:58:30AM +0200, Avi Kivity wrote:
> On 03/25/2010 11:44 AM, Michael S. Tsirkin wrote:
>> On Thu, Mar 25, 2010 at 11:40:09AM +0200, Avi Kivity wrote:
>>    
>>> On 03/25/2010 11:15 AM, Michael S. Tsirkin wrote:
>>>      
>>>> - Why are you using 32 bit long memory accesses for interrupts?
>>>>     16 bit IO eould be enough and it's faster. This what virtio-pci does.
>>>>
>>>>
>>>>        
>>> Why is 16 bit io faster?
>>>      
>> Something to do with need for emulation to get address/data
>> for pci memory accesses?
>>    
>
> pio is definitely faster than mmio (all that is needed is to set one bit  
> on the BAR).  But 32 vs. 16 makes no difference.

Right. That's what I meant.

> -- 
> error compiling committee.c: too many arguments to function

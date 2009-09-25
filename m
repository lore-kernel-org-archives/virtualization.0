From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Fri, 25 Sep 2009 10:43:47 +0300
Message-ID: <4ABC74B3.9070102__48337.7193603248$1253864700$gmane$org@redhat.com>
References: <4AB1A8FD.2010805@gmail.com>
	<20090921214312.GJ7182@ovro.caltech.edu>
	<4AB89C48.4020903@redhat.com> <4ABA3005.60905@gmail.com>
	<4ABA32AF.50602@redhat.com> <4ABA3A73.5090508@gmail.com>
	<4ABA61D1.80703@gmail.com> <4ABA78DC.7070604@redhat.com>
	<4ABA8FDC.5010008@gmail.com> <4ABB1D44.5000007@redhat.com>
	<20090924192754.GA14341@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090924192754.GA14341@ovro.caltech.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/24/2009 10:27 PM, Ira W. Snyder wrote:
>>> Ira can make ira-bus, and ira-eventfd, etc, etc.
>>>
>>> Each iteration will invariably introduce duplicated parts of the stack.
>>>
>>>        
>> Invariably?  Use libraries (virtio-shmem.ko, libvhost.so).
>>
>>      
> Referencing libraries that don't yet exist doesn't seem like a good
> argument against vbus from my point of view. I'm not speficially
> advocating for vbus; I'm just letting you know how it looks to another
> developer in the trenches.
>    

My argument is that we shouldn't write a new framework instead of fixing 
or extending an existing one.

> If you'd like to see the amount of duplication present, look at the code
> I'm currently working on.

Yes, virtio-phys-guest looks pretty much duplicated.  Looks like it 
should be pretty easy to deduplicate.

>   It mostly works at this point, though I
> haven't finished my userspace, nor figured out how to actually transfer
> data.
>
> The current question I have (just to let you know where I am in
> development) is:
>
> I have the physical address of the remote data, but how do I get it into
> a userspace buffer, so I can pass it to tun?
>    

vhost does guest physical address to host userspace address (it your 
scenario, remote physical to local virtual) using a table of memory 
slots; there's an ioctl that allows userspace to initialize that table.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: 0-copy (was Re: question: asynchronous notification from vhost)
Date: Tue, 15 Oct 2019 16:42:04 +0200
Message-ID: <20191015144203.GA1829@ubuntu>
References: <20191015092313.GA31275@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191015092313.GA31275@ubuntu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 15, 2019 at 11:23:13AM +0200, Guennadi Liakhovetski wrote:
> Hi,
> 
> I'm developing a virtualised audio / DSP virtio and vhost driver pair 
> and I'm currently somewhat stuck trying to figure out how to 
> asynchronously notify the guest from the vhost driver. I'm using the 
> vhost_add_used_and_signal() function to return data back to the guest 
> in the guest context, when the guest initiated an operation, that's 
> working well. But how do I "kick" the guest from an asynchronous, e.g. 
> from an interrupt thread context?

I think I've solved that by using a vhost work queue. That brings me 
one step further, possibly, to the last larger problem to solve: the 
actual data transmission. My preference would be to use zero-copy 
for that, but so far I only see one example of zero-copy in 
drivers/vhost - in net.c and only in TX direction. As far as I 
understand that isn't a principal limitation of the vhost / virtio 
API, rather it's related to certain networking specifics. Am I 
right? Is it supposed to work in both firections, or are there 
problems?

Thanks
Guennadi

From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 10 Aug 2009 19:16:48 -0500
Message-ID: <4A80B870.9080907__12172.6016085178$1249949875$gmane$org@codemonkey.ws>
References: <20090805175713.GB28738@shareable.org>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com>
	<200908110839.28901.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908110839.28901.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Mon, 10 Aug 2009 07:17:54 pm Gerd Hoffmann wrote:
>   
>> On 08/10/09 08:55, Amit Shah wrote:
>>     
>>>> Bad example.  Quite a lot of modern devices drivers are using dynamic
>>>> major/minor numbers because they have proven to be such a pain in the
>>>> butt.  That's why we have more sophisticated mechanisms like udev for
>>>> userspace to make use of.
>>>>         
>>> Let me explain how we came to this numbering: we first had support for
>>> 'naming' ports and the names were obtained by userspace programs by an
>>> ioctl. Rusty suggested to use some numbering scheme where some ports
>>> could exist at predefined locations so that we wouldn't need the naming
>>> and the ioctls around it.
>>>       
>> I think the naming is very important.
>>     
>
> I disagree.  If you can hand out names, you can hand out numbers.

The problem with handing out names is that there has to be someone to 
"hand" things out.  And even if you have a good hander-outer, 
development is difficult in a distributed environment because you may 
have folks using your code before you've gotten an official hand-out.

A better discovery mechanism is based on something that piggy backs on 
another authority.  For instance, reverse fully qualified domains work 
well.  uuid's tend to work pretty well too although it's not perfect.

In general, even just open strings can work out okay given that people 
are responsible in how they name things.

Regards,

Anthony Liguori

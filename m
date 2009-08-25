From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for  host-guest
	communication
Date: Tue, 25 Aug 2009 15:00:51 +0200
Message-ID: <4A93E083.8060306__36039.3987190493$1251205856$gmane$org@redhat.com>
References: <20090806173740.GA1178@shareable.org>
	<200908201701.30467.rusty@rustcorp.com.au>
	<4A8CFEDD.4000009@redhat.com>
	<200908252213.06729.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908252213.06729.rusty@rustcorp.com.au>
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
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/25/09 14:43, Rusty Russell wrote:
> On Thu, 20 Aug 2009 05:14:29 pm Gerd Hoffmann wrote:
>> I think strings are better as numbers for identifying protocols as you
>> can work without a central registry for the numbers then.
>
> Yep, all you need is a central registry for names :)

There are schemes to do without (reverse domain names, i.e. 
au.com.rustcorp.* is all yours and you don't have to register).  Also 
with names the namespace is much bigger and clashes are much less 
likely, so chances that it works out with everybody simply picking a 
sane name are much higher.

cheers,
   Gerd

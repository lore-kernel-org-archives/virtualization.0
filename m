From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Xen-devel] is kexec on Xen domU possible?
Date: Wed, 24 Jul 2013 00:49:25 -0700
Message-ID: <87ob9so0sa.fsf@xmission.com>
References: <20130719131819.GC11233@debian70-amd64.local.net-space.pl>
	<20130719151243.GA15488@kroah.com>
	<20130719183235.GA12267@debian70-amd64.local.net-space.pl>
	<20130719191449.GA1882@kroah.com> <51E9A85D.2060206@zytor.com>
	<20130722170307.GB14451@debian70-amd64.local.net-space.pl>
	<87wqoise9d.fsf@xmission.com> <51ED78EE.9020903@zytor.com>
	<20130722183315.GA29273@kroah.com>
	<20130724002235.GA15047@u109add4315675089e695.ant.amazon.com>
	<20130724004058.GA20327@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130724004058.GA20327@kroah.com> (Greg KH's message of "Tue, 23
	Jul 2013 17:40:58 -0700")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: xen-devel@lists.xensource.com, Brandon Philips <brandon@ifup.org>, Daniel Kiper <daniel.kiper@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Matt Wilson <msw@amazon.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Jul 23, 2013 at 05:22:36PM -0700, Matt Wilson wrote:
>> On Mon, Jul 22, 2013 at 11:33:15AM -0700, Greg KH wrote:
>> > On Mon, Jul 22, 2013 at 11:24:46AM -0700, H. Peter Anvin wrote:
>> > > On 07/22/2013 10:20 AM, Eric W. Biederman wrote:
>> 
>> Many Xen-based cloud providers provide a mechanism for users to boot
>> the kernels they want. For example you can use PV-GRUB on EC2
>> instances to boot a kernel that is stored within an AMI.
>> 
>> For more info:
>>   http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html
>
> Yes, that's quite true, but some don't, or they make it difficult to do
> so.  Using kexec also allows you to "be the bootloader" and decide on
> _which_ kernel you want to boot, independant of what cloud provider you
> use, something that lots of people want in their quest to not dependant
> on any one company.

I would be more than happy to review and help get something merged that
sorts out kexec on Xen.

Eric

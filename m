From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Wed, 27 Mar 2013 07:21:42 -0700
Message-ID: <3ceb5414-fb1a-4d3e-811d-ef66478b8adf@email.android.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com>
	<8738vjer43.fsf@rustcorp.com.au>
	<20130326193911.GA19251@redhat.com>
	<87ip4d4sef.fsf@rustcorp.com.au>
	<79aede60-5692-4d27-9cfa-7b5fbf96b987@email.android.com>
	<51525A03.1010906@zytor.com> <20130327112643.GF24243@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130327112643.GF24243@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We probably shouldn't given the requirement for PCIe devices to be able to operate without configured I/O BARs.

On the other hand what about a host which can only virtualize I/O for some reason... not sure if that is a realistic scenario.

"Michael S. Tsirkin" <mst@redhat.com> wrote:

>On Tue, Mar 26, 2013 at 07:31:31PM -0700, H. Peter Anvin wrote:
>> On 03/26/2013 05:22 PM, H. Peter Anvin wrote:
>> > I would say let it be undefined... in most cases the host will know
>what device(s) will matter; e.g. if the guest is ppc no point in
>providing an I/O BAR.
>> 
>> For pluggable physical devices, though, both should be provided.
>> 
>> 	-hpa
>
>Yes but what Rusty asked, is whether we should make the memory BAR
>optional.
>
>> -- 
>> H. Peter Anvin, Intel Open Source Technology Center
>> I work for Intel.  I don't speak on their behalf.

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

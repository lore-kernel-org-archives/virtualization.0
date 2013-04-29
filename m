From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: suggesting wording fixes for virtio-spec 0.9.5
Date: Mon, 29 Apr 2013 10:15:25 +0930
Message-ID: <878v42dv16.fsf@rustcorp.com.au>
References: <517579AC.2050400@redhat.com> <87r4i1gadv.fsf@rustcorp.com.au>
	<517656D4.2050901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <517656D4.2050901@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Laszlo Ersek <lersek@redhat.com> writes:
> On 04/23/13 06:05, Rusty Russell wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>>> Hi,
>>>
>>> (I'm not subscribed to either list,)
>>>
>>> using the word "descriptor" is misleading in the following sections:
>> 
>> Yes, I like the use of 'descriptor chains'.  This is a definite
>> improvement.
...
> Not sure if it's customary here or if you need it / want it, but anyway
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Not needed, but always useful to ahve confirmation that I didn't
introduce another mistake while fixing my old ones!

> (Also I've fixed the OVMF driver; just reposting the patch today with a
> better commit message.)
>
> Thanks much!
> Laszlo

Cheers,
Rusty.

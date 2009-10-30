From: Hannes Reinecke <hare@suse.de>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Fri, 30 Oct 2009 09:12:08 +0100
Message-ID: <4AEA9FD8.6070007__23565.2840849527$1256890408$gmane$org@suse.de>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
	<4AE822E7.2010108@redhat.com> <4AE84E09.7090002@redhat.com>
	<20091028202522.r53660olwsk8cokk@imap.suse.de>
	<20091029043708.GA3552@lst.de> <4AE99144.6050904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AE99144.6050904@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> On 10/29/09 05:37, Christoph Hellwig wrote:
>>> So something like
>>> - Get next request
>>> - Attach iovec/bounc-buffer
>>> - handle request (command/write/read)
>>> - complete request (callback)
>>
>> Btw, from some previuous attempts to sort out this code here are some
>> thing that I think would be beneficial:
> =

> Trying to go forward in review+bisect friendly baby steps.  Here is what
> I have now:
> =

> http://repo.or.cz/w/qemu/kraxel.git?a=3Dshortlog;h=3Drefs/heads/scsi.v1
> =

> It is far from being completed, will continue tomorrow.  Should give a
> idea of the direction I'm heading to though.  Comments welcome.
> =

Yep, this looks good.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

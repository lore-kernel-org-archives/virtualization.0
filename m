From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Tue, 03 Nov 2009 22:03:25 +0100
Message-ID: <4AF09A9D.8020501__38831.4519696452$1257282271$gmane$org@redhat.com>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
	<4AE822E7.2010108@redhat.com> <4AE84E09.7090002@redhat.com>
	<20091028202522.r53660olwsk8cokk@imap.suse.de>
	<20091029043708.GA3552@lst.de> <4AE99144.6050904@redhat.com>
	<4AEA9FD8.6070007@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AEA9FD8.6070007@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/30/09 09:12, Hannes Reinecke wrote:
> Gerd Hoffmann wrote:
>> http://repo.or.cz/w/qemu/kraxel.git?a=shortlog;h=refs/heads/scsi.v1
>>
>> It is far from being completed, will continue tomorrow.  Should give a
>> idea of the direction I'm heading to though.  Comments welcome.
>>
> Yep, this looks good.

More bits available now at:

http://repo.or.cz/w/qemu/kraxel.git/shortlog/refs/heads/scsi.v3

Please have a look at the new interface, this commit:

http://repo.or.cz/w/qemu/kraxel.git/commitdiff/9c825dac540282dd4d5f5f660ca13af617888037

The workflow I have in mind is:

   ->request_new()

Returns a parsed request, i.e. all fields of req->cmd are filled 
already, so the host adapter can easily check whenever it is a read or 
write and how many bytes will be transfered.

   ->request_run()

Execute the command.  iovec is passed to the dma_bdrv_*() functions, 
which means it should contain guest physical addresses.

When the request is done the complete callback is called.  For commands 
which complete immediately the callback might be called before 
request_run() returns.  Or maybe don't call the callback at all then? 
We can easily indicate using the return value that we are done already.

   ->request_del()

Release request when done.

Questions & comments are welcome.

cheers,
   Gerd

From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 3/4] virtio: rng: delay hwrng_register() till driver is
	ready
Date: Wed, 23 Jul 2014 15:21:13 +0930
Message-ID: <8761iozkq6.fsf@rustcorp.com.au>
References: <cover.1405942162.git.amit.shah@redhat.com>
	<91cb7c5b87cf2ba5ef1bacd55a7ee7bc827293a2.1405942162.git.amit.shah@redhat.com>
	<20140722170834.GA23129@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140722170834.GA23129@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org
Cc: jason@lakedaemon.net, herbert@gondor.apana.org.au, keescook@chromium.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Mon) 21 Jul 2014 [17:15:51], Amit Shah wrote:
>> Instead of calling hwrng_register() in the probe routing, call it in the
>> scan routine.  This ensures that when hwrng_register() is successful,
>> and it requests a few random bytes to seed the kernel's pool at init,
>> we're ready to service that request.
>> 
>> This will also enable us to remove the workaround added previously to
>> check whether probe was completed, and only then ask for data from the
>> host.  The revert follows in the next commit.
>> 
>> There's a slight behaviour change here on unsuccessful hwrng_register().
>> Previously, when hwrng_unregister() failed, the probe() routine would
>
> typo: should be hwrng_register().
>
> Please fix this up when picking up the patch.

Done.

All 4 patches applied!
Rusty.

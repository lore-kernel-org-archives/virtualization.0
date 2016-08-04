From: Minfei Huang <minfei.hmf@alibaba-inc.com>
Subject: Re: [PATCH v3] virtio_blk: Fix a slient kernel panic
Date: Thu, 4 Aug 2016 13:35:09 +0800
Message-ID: <383B4F24-A757-4206-B251-04B9FBC4FBCD@alibaba-inc.com>
References: <1468902762-43268-1-git-send-email-mnfhuang@gmail.com>
	<CAJSP0QUZ-=va4yOLMciG0V0L9N+XcDAcc82vVfdTw=RY-UXVcw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============5773711041336854247=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QUZ-=va4yOLMciG0V0L9N+XcDAcc82vVfdTw=RY-UXVcw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: fanc.fnst@cn.fujitsu.com, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============5773711041336854247==
Content-Type: multipart/signed; boundary="Apple-Mail=_17A6AEBA-DF31-4B79-B521-D93463786A2B"; protocol="application/pkcs7-signature"; micalg=sha1


--Apple-Mail=_17A6AEBA-DF31-4B79-B521-D93463786A2B
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi, Michael.

Since Stefan and Cornelia have review-acked this patch, could you mind
helping review this patch?

Thanks
Minfei

> On Jul 29, 2016, at 16:26, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> 
> On Tue, Jul 19, 2016 at 5:32 AM, Minfei Huang <mnfhuang@gmail.com> wrote:
>> From: Minfei Huang <mnghuan@gmail.com>
>> 
>> We do a lot of memory allocation in function init_vq, and don't handle
>> the allocation failure properly. Then this function will return 0,
>> although initialization fails due to lacking memory. At that moment,
>> kernel will panic in guest machine, if virtio is used to drive disk.
>> 
>> To fix this bug, we should take care of allocation failure, and return
>> correct value to let caller know what happen.
>> 
>> Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
>> Signed-off-by: Minfei Huang <mnghuan@gmail.com>
>> ---
>> v2:
>> - Remove useless initialisation to NULL
>> v1:
>> - Refactor the patch to make code more readable
>> ---
>> drivers/block/virtio_blk.c | 26 ++++++++------------------
>> 1 file changed, 8 insertions(+), 18 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


--Apple-Mail=_17A6AEBA-DF31-4B79-B521-D93463786A2B
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIG7TCCAzow
ggKjoAMCAQICAQMwDQYJKoZIhvcNAQEFBQAwgZAxJjAkBgkqhkiG9w0BCQEWF2FsaWxhbmdAYWxp
YmFiYS1pbmMuY29tMRMwEQYDVQQDDApBbGlsYW5nIENBMQwwCgYDVQQLDANJbmMxEDAOBgNVBAoM
B0FsaWJhYmExETAPBgNVBAcMCEhhbmdaaG91MREwDwYDVQQIDAhaaGVKaWFuZzELMAkGA1UEBhMC
Q04wHhcNMTQwMzIxMTgyNjQ4WhcNMzQwMzE2MTgyNjQ4WjA/MR0wGwYDVQQDDBRBbGlsYW5nIENs
YXNzIDMgUm9vdDEMMAoGA1UECwwDSW5jMRAwDgYDVQQKDAdBbGliYWJhMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDkSZUxhsryrulw7ShMNYBuF61+lkYT1/ydmAXyMyMXhSGaKJo6onqdui8W
3X8TZ44E5ZMEMM3rTb0o3+t6N2G9qstbpfm/wnxlNsdFKBZAQpsTp7YKDaVGo1iMir6NE5VXtlZc
ZlfdXLncAGxGIDITf6+7nvWWU2eQCAdeGH4+iwIDAQABo4HzMIHwMB0GA1UdDgQWBBS8GDnn09jS
1FKSW9ID4Szifw9bNTCBvQYDVR0jBIG1MIGygBRsQqcG9DDm61l1oc2mKWiF5GLUraGBlqSBkzCB
kDEmMCQGCSqGSIb3DQEJARYXYWxpbGFuZ0BhbGliYWJhLWluYy5jb20xEzARBgNVBAMMCkFsaWxh
bmcgQ0ExDDAKBgNVBAsMA0luYzEQMA4GA1UECgwHQWxpYmFiYTERMA8GA1UEBwwISGFuZ1pob3Ux
ETAPBgNVBAgMCFpoZUppYW5nMQswCQYDVQQGEwJDToIBATAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBBQUAA4GBAAfkwgwem9gawUb7wU4oiGw2aCw6QbKgfSBv+Dj6RiA4CJztW0IF6g6cRM85
Uv6+AoGyC14x871UJBHNt75ZBgSyvZpXu2n3BLQmTe3gQNXsipOvCSlM2V98U/KVKRgUgzb6dNDd
jMzv9yEIGuar9zbk5GRDDSQR+qTM+a8i2umFMIIDqzCCAxSgAwIBAgIGAVUPrrJzMA0GCSqGSIb3
DQEBBQUAMD8xHTAbBgNVBAMMFEFsaWxhbmcgQ2xhc3MgMyBSb290MQwwCgYDVQQLDANJbmMxEDAO
BgNVBAoMB0FsaWJhYmEwHhcNMTYwNjAxMDU1NTU1WhcNMjEwNTMxMDU1NTU1WjCB2zEpMCcGCSqG
SIb3DQEJARYabWluZmVpLmhtZkBhbGliYWJhLWluYy5jb20xDzANBgNVBAMMBjExMzAzNTFKMEgG
A1UEDAxBMTEzMDM1fE1ETVNFUlZFUjU1QTFFQUZGLTM4OEQtNTA1Ri1COEFDLUNFRUQzNkM5RUQ1
NHxmNDVjODljYjM0MTkxDDAKBgNVBAsMA0luYzEQMA4GA1UECgwHQWxpYmFiYTERMA8GA1UEBwwI
SGFuZ1pob3UxETAPBgNVBAgMCFpoZUppYW5nMQswCQYDVQQGEwJDTjCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAoQP5AB+zGOj1kQmLU2TOrZOrHMdjx//VHpNfn8k3oxuiuMJSmOfHmOeaurks
qZUz7EoQtyDn8alAQ9t9Zx9sRIlXKlcouZYClQ1Hfh5n531YaOOImYmpOENUGo1nzOydZZ8S7ciy
iR1E9nWrNFyA3gZpegzRIMLLwvzZ5wyHhoECAwEAAaOCARMwggEPMBgGBikBAQINHgQOBAxmNDVj
ODljYjM0MTkwDwYGKQEBAgQeBAUEA29zeDA5BgYpAQECDB4ELwQtTURNU0VSVkVSNTVBMUVBRkYt
Mzg4RC01MDVGLUI4QUMtQ0VFRDM2QzlFRDU0MBIGBikBAQILHgQIBAYxMTMwMzUwRQYDVR0lBD4w
PAYIKwYBBQUHAwEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAw0GCCsGAQUFBwMOBggrBgEF
BQcDETAMBgNVHQ8EBQMDB/+AMB0GA1UdDgQWBBSO56p18ShLWQWQMh/iUGRoFnLK/jAfBgNVHSME
GDAWgBS8GDnn09jS1FKSW9ID4Szifw9bNTANBgkqhkiG9w0BAQUFAAOBgQBek3RUP+ru9F7OkTJI
Jas0xBvfC8RCxifD7EG/VSLb43hsd2my9sgyQN1x32sJmBlmeUpAAjZ4a2x35Jyxs26VJEknasub
8x7pcDjSL4KkNS1IjWPFaRzx7JTTGwfcEIxlIxFhG8PvWWKRgJjJzDS8fPQ1dSqh8oyxPJ73PD3X
+DGCAgYwggICAgEBMEkwPzEdMBsGA1UEAwwUQWxpbGFuZyBDbGFzcyAzIFJvb3QxDDAKBgNVBAsM
A0luYzEQMA4GA1UECgwHQWxpYmFiYQIGAVUPrrJzMAkGBSsOAwIaBQCgggETMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MDgwNDA1MzUxMFowIwYJKoZIhvcNAQkE
MRYEFOlAbAP8Kc6N7cMR+Fd3PAv5NjjrMFgGCSsGAQQBgjcQBDFLMEkwPzEdMBsGA1UEAwwUQWxp
bGFuZyBDbGFzcyAzIFJvb3QxDDAKBgNVBAsMA0luYzEQMA4GA1UECgwHQWxpYmFiYQIGAVUPrrJz
MFoGCyqGSIb3DQEJEAILMUugSTA/MR0wGwYDVQQDDBRBbGlsYW5nIENsYXNzIDMgUm9vdDEMMAoG
A1UECwwDSW5jMRAwDgYDVQQKDAdBbGliYWJhAgYBVQ+usnMwDQYJKoZIhvcNAQEBBQAEgYAtHSVa
eVmrHWB2UCH9f9EWxoXbdErbqkulUuuQ2XKj9jTvdPhIYw4f4mf0n817xONdorn402Qnc5+g8heF
eZid0ncRGHpYkdsnUa+KjREGhHaRp47q5BFulbucBbsiTqT6ASD8serBcHt4h0RwFnsOWB/wDVU+
9POFHX0fsl47DQAAAAAAAA==
--Apple-Mail=_17A6AEBA-DF31-4B79-B521-D93463786A2B--

--===============5773711041336854247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5773711041336854247==--

From: Minfei Huang <minfei.hmf@alibaba-inc.com>
Subject: Re: [PATCH v3] virtio_blk: Fix a slient kernel panic
Date: Sat, 23 Jul 2016 09:58:55 +0800
Message-ID: <B9BE2409-56EE-4521-9723-4A3BE2EFC511__34852.990465197$1469306753$gmane$org@alibaba-inc.com>
References: <1468902762-43268-1-git-send-email-mnfhuang@gmail.com>
	<20160719142243.1c62ac03.cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============5877317809852399827=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160719142243.1c62ac03.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Minfei Huang <mnghuan@gmail.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, fanc.fnst@cn.fujitsu.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============5877317809852399827==
Content-Type: multipart/signed; boundary="Apple-Mail=_5483BFF6-316D-4B71-A771-57E9B6F06C8A"; protocol="application/pkcs7-signature"; micalg=sha1


--Apple-Mail=_5483BFF6-316D-4B71-A771-57E9B6F06C8A
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


Ping, Any comment is appreciate.

Thanks
Minfei

> On Jul 19, 2016, at 20:22, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> On Tue, 19 Jul 2016 12:32:42 +0800
> Minfei Huang <mnfhuang@gmail.com> wrote:
> 
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
> Your changes certainly make the function more compact.
> 
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>


--Apple-Mail=_5483BFF6-316D-4B71-A771-57E9B6F06C8A
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
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MDcyMzAxNTg1NVowIwYJKoZIhvcNAQkE
MRYEFHTi9Q2dNW7C+1rbMSWC/OlP/W52MFgGCSsGAQQBgjcQBDFLMEkwPzEdMBsGA1UEAwwUQWxp
bGFuZyBDbGFzcyAzIFJvb3QxDDAKBgNVBAsMA0luYzEQMA4GA1UECgwHQWxpYmFiYQIGAVUPrrJz
MFoGCyqGSIb3DQEJEAILMUugSTA/MR0wGwYDVQQDDBRBbGlsYW5nIENsYXNzIDMgUm9vdDEMMAoG
A1UECwwDSW5jMRAwDgYDVQQKDAdBbGliYWJhAgYBVQ+usnMwDQYJKoZIhvcNAQEBBQAEgYAMXhxq
HQO7Iu6SyjPAtuu+6HkG4Rvs7YOGFR29ZwudAsF+BewfG/+gsvraa4yBzNrJXkkSaQxW5X2xaZXV
9H38tputy5CViHZb4UwbL3AH99yichgt5QsU37Y9eVD2Kp6wWYDgeTn5ExgAXMWbLyjHxXIxIeDP
NTNBQRle3DP/AgAAAAAAAA==
--Apple-Mail=_5483BFF6-316D-4B71-A771-57E9B6F06C8A--

--===============5877317809852399827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5877317809852399827==--
